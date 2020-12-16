//usr/bin/env true && "$(dirname $0)"/node_modules/.bin/ts-node --compiler-options='{"strict":true,"lib":["es2019"]}' $0 ; exit $?

import {readFileSync} from 'fs';

type Ticket = number[];
type Constraint = { min: number; max: number };
type Rule = {
    name: string;
    constraints: [Constraint, Constraint]
};

function readInput() {
    const inputString = readFileSync('day16-input.txt', 'utf8');

    const [ruleSection, yourTicketSection, nearbyTicketSection] = inputString.trim().split(/\n\n.*:\n/);

    const nearbyTickets: Ticket[] = nearbyTicketSection
        .trim()
        .split('\n')
        .map(ticketLine =>
            ticketLine
                .trim()
                .split(',')
                .map(i => parseInt(i)),
        );

    const rules: Rule[] = ruleSection
        .trim()
        .split('\n')
        .map(ruleLine => {
            const [name, constraintsString] = ruleLine.split(': ');
            const [c1, c2] = constraintsString.split(' or ').map(constraintsString => {
                const [min, max] = constraintsString.split('-').map(i => parseInt(i));
                return {min, max};
            });
            return {name, constraints: [c1, c2]};
        });

    return {rules, nearbyTickets};
}

const input = readInput();

function ticketNumValidForAtLeastOneField(num: number): boolean {
    for (const {constraints: [c1, c2]} of input.rules) {
        if ((num >= c1.min && num <= c1.max) || (num >= c2.min && num <= c2.max)) {
            return true;
        }
    }
    return false;
}

const part1: any = input.nearbyTickets
    .flatMap(ticket => ticket.filter(n => !ticketNumValidForAtLeastOneField(n)))
    .reduce((a, b) => a + b);

console.log(part1);
